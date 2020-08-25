class ApiClient {
  constructor(baseUrl) {
    this.baseUrl = baseUrl;
    this.timeout = 10000;
    this.token = railsAppConfig.uuid;
    this.locale = railsAppConfig.locale;
  }

  // Set base Headers
  setHeaders(xhr) {
    xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
    xhr.setRequestHeader("Authorization", "Token token=" + this.token);
    xhr.setRequestHeader("Accept-Language", this.locale);
    xhr.timeout = this.timeout;
  }

  // On error
  onError(xhr, errorCallback) {
    xhr.onerror = function() {
      errorCallback({
        message: appTranslations.errors.server.unknown
      });
    };
  }

  // On timeout error
  onTimeout(xhr, errorCallback) {
    xhr.ontimeout = function() {
      xhr.abort();
      errorCallback({
        message: appTranslations.errors.server.timeout
      });
    };
  }

  // On done
  onDone(xhr, dataCallback, errorCallback) {
    if (xhr.status !== 200 && xhr.status !== 204) {
      if (xhr.responseText && xhr.responseText.length > 0) {
        let data = JSON.parse(xhr.responseText);
        errorCallback({
          message: data.error,
          code: xhr.status
        });
      } else {
        errorCallback({
          message: appTranslations.errors.server.unknown
        });
      }
    } else {
      if(xhr.responseText.length > 0) {
        dataCallback(JSON.parse(xhr.responseText));
      } else {
        dataCallback();
      }

    }
  }

  // On ready state change
  onReadyStateChange(xhr, dataCallback, errorCallback) {
    let self = this;
    xhr.onreadystatechange = function() {
      switch (xhr.readyState) {
        case 0:
          // console.log('UNSENT');
          break;
        case 1:
          // console.log('OPENED');
          break;
        case 2:
          // console.log('HEADERS_RECEIVED');
          break;
        case 3:
          // console.log('LOADING');
          break;
        case 4:
          // console.log('DONE');
          self.onDone(xhr, dataCallback, errorCallback);
          break;
        default:
          return;
      }
    };
  }

  /**
   * HTTP GET
   * @param path
   * @returns {Promise<any>}
   */
  get(path) {
    return new Promise((resolve, reject) => {
      let xhr = new XMLHttpRequest();
      this.onError(xhr, reject);
      this.onTimeout(xhr, reject);
      this.onReadyStateChange(xhr, resolve, reject);

      xhr.open("GET", this.baseUrl + path, true);
      this.setHeaders(xhr);
      xhr.send();
    });
  }

  // HTTP POST
  post(path, data) {
    return new Promise((resolve, reject) => {
      let xhr = new XMLHttpRequest();
      this.onError(xhr, reject);
      this.onTimeout(xhr, reject);
      this.onReadyStateChange(xhr, resolve, reject);

      xhr.open("POST", this.baseUrl + path, true);
      this.setHeaders(xhr);
      xhr.send(JSON.stringify(data));
    });
  }

  // HTTP DELETE
  delete(path) {
    return new Promise((resolve, reject) => {
      let xhr = new XMLHttpRequest();
      this.onError(xhr, reject);
      this.onTimeout(xhr, reject);
      this.onReadyStateChange(xhr, resolve, reject);
      xhr.open("DELETE", this.baseUrl + path, true);
      this.setHeaders(xhr);
      xhr.send();
    });
  }
}
