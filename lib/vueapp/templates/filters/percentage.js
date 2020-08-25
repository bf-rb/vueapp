/**
 * Filter for percentage value
 * {{ 10 | percentage }} => '10%'
 */
Vue.filter("percentage", function(value) {
  return value + "%";
});
