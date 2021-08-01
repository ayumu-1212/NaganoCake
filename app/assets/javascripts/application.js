// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require data-confirm-modal
//= require activestorage
//= require turbolinks
//= require_tree .

// bootstrapのファイルフォームのデザインテンプレ
$(document).ready(function () {
  bsCustomFileInput.init()
  document.getElementById('inputFileReset').addEventListener('click', function() {
    var elem = document.getElementById('inputItemImage');
    elem.value = '';
    elem.dispatchEvent(new Event('change'));
  });
})

// public/homes/topのヘッダーの挙動
$(document).ready(function() {
  $(window).scroll(function() {
    const navbarCollapsible = document.body.querySelector('#mainNav');

    if ($(this).scrollTop() > 0) {
      navbarCollapsible.classList.add('navbar-shrink');
    } else {
      navbarCollapsible.classList.remove('navbar-shrink');
    }
  });
});

// formのvalidation
(function() {
  'use strict';
  window.addEventListener('turbolinks:load', function() {
    // カスタムブートストラップ検証スタイルを適用するすべてのフォームを取得
    var forms = document.getElementsByClassName('needs-validation');
    // ループして帰順を防ぐ
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();

// tableの行全体リンク
document.addEventListener("turbolinks:load", function() {
  $(".clickable-row").css("cursor","pointer").click(function() {
      location.href = $(this).data("href");
  });
});