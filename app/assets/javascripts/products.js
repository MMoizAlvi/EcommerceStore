$(document).on('turbolinks:load', function(){
    var products = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: {
        url: '/products/autocomplete?query=%QUERY',
        wildcard: '%QUERY'
      }
    });
    $('#products_search').typeahead(null, {
      source: products
    });
})
