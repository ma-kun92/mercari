$(function(){

  var images = gon.image
  var edit_image = $(".sell-dropbox-items-edit");
  var i_count = 1;
  function edit_images(image) {
    var html = `<li class="sell-upload-item">
                  <img src="${image}" alt="画像">
                  <div class="sell-upload-button">
                    <a href="" class="sell-upload-edit">編集</a>
                    <a href="" class="sell-upload-delete">削除</a>
                  </div>
                </li>`
    edit_image.append(html);
  }
  for (var i = 0; i < images.length - 1; i++){
    var ima = images[i]
    edit_images(ima.image.url)
    }
  var target = document.getElementById('drop-edit');
  if (target) {
    // ドラッグ
    target.addEventListener('dragover', function (e) {
      // デフォルトアクションを抑止
      e.preventDefault();
      // 親要素へのイベントの伝播をストップ
      e.stopPropagation();
      // ドロップされた要素はローカルからのコピー
      e.dataTransfer.dropEffect = 'copy';
    });

    // ドロップ
    target.addEventListener('drop', function (e) {
      e.preventDefault();
      e.stopPropagation();
      //DataTransfer.files - ファイルの一覧
      document.getElementById('item-image-edit'+ i_count).files = e.dataTransfer.files;
    });
  }

// ドロップ後 表示させとく
  $('.item-images-edit').on("change",function(e) {
    for(var i = 0; i < this.files.length; i++){
      // FileReaderを作成
      var fileReader = new FileReader();
      // 読み込み完了時のイベント
      fileReader.onload = function (e) {
      //e.target.result
        edit_image(e.target.result,i_count);
      }
      // 読み込み実行readAsDataURL()は、FileReaderのメソッド
      fileReader.readAsDataURL(this.files[i]);
      i_count += 1;
      $("label.sell-dropbox-uploader-container").attr('for','item-image-edit'+ i_count);
    }
  });
  $(".sell-form-text_number").on("load", function() {
    var price = $(this).val();
    if( price >= 300 && price <= 9999999 ){
      var fee = Math.floor(price / 10);
      var profits = Math.floor(price - fee);
      $(".right").text('¥ ' + fee);
      $(".profits-form").text('¥ ' + profits);
    }
  })
  })
