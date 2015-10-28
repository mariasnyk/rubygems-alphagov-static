// Integration of HMRC’s webchat solution

(function () {
  'use strict';
  var root = this,
    $ = root.jQuery;
  if(typeof root.GOVUK === 'undefined') { root.GOVUK = {}; }

  var webchat = {

    MAX_TRAIL_LENGTH: 10,

    trackLocation: function(){
      var govUkStorage = JSON.parse(window.sessionStorage.getItem('GOVUK')) || {};
      if ($.isArray(govUkStorage.webchatTrail)) {
        govUkStorage.webchatTrail.push(document.location);
        govUkStorage.webchatTrail.slice(0 - webchat.MAX_TRAIL_LENGTH);
      } else {
        govUkStorage.webchatTrail = [document.location];
      }
      window.sessionStorage.setItem('GOVUK',JSON.stringify(govUkStorage));
    },

    sendMessage: function(message){
      webchat.$chatFrame.get(0).contentWindow.postMessage(JSON.stringify(message), '*');
    },

    init: function (){

      $('.article-container').before('<div class="webchat-banner"><h2>Web chat</h2><p>Rather than calling us why not talk to us over the internet.</p><a href="#" class="accept">Start a web chat with HMRC</a> <a href="#" class="reject">I am not interested</a></div>');

      // IE7 can’t access webchat
      if (window.sessionStorage && window.postMessage) {

        // append the current location to the current session set
        webchat.trackLocation();

        // what’s the initialisation condition for loading the web chat?
        if (true) {
          webchat.$chatFrame = $('<iframe class="hidden" />');
          webchat.$banner = $('.webchat-banner');

          // initialise the webchat
          webchat.$chatFrame.attr('src', 'https://assets-origin.preview.alphagov.co.uk/static/webchat-iframe.html');
          //webchat.$chatFrame.attr('src', 'http://static.dev.gov.uk/static/webchat-iframe.html');
          webchat.$chatFrame.on('load', function() {
            webchat.sendMessage({
              evt: 'load',
              // url: 'https://www.preview.alphagov.co.uk/government/organisations/hm-revenue-customs/contact/self-assessment',
              // title: 'Self%20Assessment:%20general%20enquiries%20-%20Contact%20HMRC%20-%20GOV.UK'
              url: window.location,
              title: window.document.title
            });
          });
          webchat.$chatFrame.appendTo('body');

          // hide / show the banner based on status of the webchat
          $(window).on('message', function(e) {
            e = e.originalEvent;
            //if (e.origin === 'https://www.gov.uk') {
              if (e.data === 'opened') {
                webchat.$banner.addClass('open');
              } else if (e.data === 'closed') {
                webchat.$banner.removeClass('open');
              }
            //}
          });

          // let a user accept / reject a webchat
          webchat.$banner.on('click', '.accept', function(e) {
            e.preventDefault();
            webchat.sendMessage({ evt: 'accept' });    
          }).on('click', '.reject', function(e) {
            e.preventDefault();
            webchat.sendMessage({ evt: 'reject' });    
          });

        }

      }
    }
  };

  root.GOVUK.webchat = webchat;
}).call(this);
