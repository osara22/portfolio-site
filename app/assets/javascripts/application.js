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


//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require tag-it

//= require flickity.pkgd.min

//= require rails-ujs
//= require activestorage
//= require_tree .

// topのスライドショーの設定

$(function(){
  $('.js-flickity').flickity({

    //　無限スクロール
    wrapAround: true,

    //　trueでラッパー要素の中で収まるようにスクロールする
    contain: true,

    // trueでスライドの始まりが右になる
    rightToLeft: true,

    // falseで「前へ」「次へ」のボタンの非表示
    prevNextButtons: false,

    // falseでドットナビゲーションを非表示
    pageDots: false,

    // trueで3秒間隔で自動スクロール。
    autoPlay: true

  });
});

// noticeの表示に動きを作る
$(function(){
  $('.notice').delay(500).slideDown();
});
$(function(){
  $('.notice').delay(5000).slideUp();
});

$(function(){
  $('.alert').delay(500).slideDown();
});
$(function(){
  $('.alert').delay(5000).slideUp();
});