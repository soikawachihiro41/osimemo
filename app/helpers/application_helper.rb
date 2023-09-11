module ApplicationHelper
  def default_meta_tags
    {
      site: 'Pluspo',
      title: 'あなたが愛する「推し」との思い出の写真をLINEbotでランダムに届けてくれるサービスです。',
      reverse: true,
      charset: 'utf-8',
      description: 'osiMemoriesを使えば、大切なに人との思い出をアルバムにできます。',
      keywords: '推し,アイドル',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('3.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        image: image_url('3.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end
