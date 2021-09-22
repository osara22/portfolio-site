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

    wrapAround: true,
    //　無限スクロール

    contain: true,
    //　trueでラッパー要素の中で収まるようにスクロールする。falseではみ出た部分に余白ができる。デフォルトはfalse。(wrapAround: trueの場合は無視される)

    rightToLeft: true,
    // trueでスライドの始まりが右になる。デフォルトはfalse。

    prevNextButtons: false,
    // falseで「前へ」「次へ」のボタンの非表示。デフォルトはtrue。

    pageDots: false,
    // falseでドットナビゲーションを非表示。デフォルトはtrue。

    reseze: false,
    // falseでリサイズした時にサイズ変更しない。デフォルトはtrue。

    autoPlay: true
    // trueで3秒間隔で自動スクロール。秒数を指定したい場合は1500などミリ秒で指定する。デフォルトはfalse。

  });
});