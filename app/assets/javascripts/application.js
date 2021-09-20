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
//= require_tree .

//= require rails-ujs
//= require activestorage
//= require_tree .

// ページ更新でtag-it発火
$(document).ready(function() {
  $(".tag_form").tagit({  // 指定のセレクタ( 今回は、:tag_list の text_field )に、tag-itを反映
    tagLimit:10,  // タグの最大数
    singleField: true,  // タグの一意性
  });
  let tag_count = 10 - $(".tagit-choice").length  // タグの数を数える
  $(".ui-widget-content.ui-autocomplete-input").attr(
    'placeholder','あと' + tag_count + '個登録できます');
})

// 残りタグ数を表示
$(document).on("keyup", '.tagit', function() {
  let tag_count = 10 - $(".tagit-choice").length
  $(".ui-widget-content.ui-autocomplete-input").attr(
  'placeholder','あと' + tag_count + '個登録できます');
});