(function() {
  "use strict";
  window.GOVUK = window.GOVUK || {};
  window.GOVUK.Analytics = window.GOVUK.Analytics || {};

  var Tracker = function(universalId, classicId) {
    this.universal = new GOVUK.Analytics.GoogleAnalyticsUniversalTracker(universalId, '.www.gov.uk');
    this.classic = new GOVUK.Analytics.GoogleAnalyticsClassicTracker(classicId, '.www.gov.uk');
    this.trackPageview();
  };

  Tracker.load = function() {
    GOVUK.Analytics.GoogleAnalyticsClassicTracker.load();
    GOVUK.Analytics.GoogleAnalyticsUniversalTracker.load();
  };

  Tracker.prototype.trackPageview = function(path, title) {
    this.classic.trackPageview(path);
    this.universal.trackPageview(path, title);
  }

  Tracker.prototype.trackEvent = function(category, action, label, value) {
    this.classic.trackEvent(category, action, label, value);
    this.universal.trackEvent(category, action, label, value);
  }

  Tracker.prototype.setDimension = function(index, value, name) {
    var PAGE_LEVEL_SCOPE = 3;
    this.universal.setDimension(index, value);
    this.classic.setCustomVariable(index, value, name, PAGE_LEVEL_SCOPE);
  };

  GOVUK.Analytics.Tracker = Tracker;
})();
