# コマンド

```sh
tweet [-i IMAGE_URL] MSG MSG MSG ...
```

# 要件

## 位置引数`MSG`

　段落。末尾に2つの改行がつく。

```
MSG1

MSG2

MSG3
```

URLのときは`https://...`だし、ハッシュタグのときは` #tags `のように書く。

## -i

　画像URLを渡す。

　URLでなくファイルシステムによるパスのときは、Flickr APIによりアップロードして取得したURLを渡す。

# API

```sh
curl -X POST -H "Content-Type: application/json" -d '{"value1":"'"$1"'"}' https://maker.ifttt.com/trigger/$IFFFT_EVENT/with/key/$IFFFT_KEY
```

```sh
curl -X POST -H "Content-Type: application/json" -d '{"value1":"'"$MESSAGE"'", "value2":"'"$IMAGE_URL"'"}' https://maker.ifttt.com/trigger/$IFFFT_EVENT/with/key/$IFFFT_KEY
```

# events

* send_tweet
* send_tweet_with_image

　IFTTTで作成したWebhooksの名前。これがURLの`$IFTTT_EVENT`にセットされる。

