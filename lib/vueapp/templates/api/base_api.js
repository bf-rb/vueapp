class BaseApi {
    constructor () {
        this.apiClient = new ApiClient(
            'url'
        );
    }

    all() {
        return this.apiClient.get('/chats.json');
    }

    show(chatId) {
        return this.apiClient.get('/chats/' + chatId + '.json');
    }

    send(chatId, message) {
        return this.apiClient.post(
            '/chats/' + chatId + '/messages.json',
            { content: message }
        );
    }

    search(query) {
        return this.apiClient.get('/languages.json?q=' + query);
    }

}
