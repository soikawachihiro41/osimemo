module ApplicationHelper
  def default_meta_tags
    {
      site: 'Pluspo',
      title: 'あなたが愛する「推し」との思い出の写真をLINEbotでランダムに届けてくれるサービスです。',
      reverse: true,
      charset: 'utf-8',
      description: 'osimemorysを使えば、「推し」との思い出が簡単に振り返れます。',
      keywords: 'osimemorys',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('3-1.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('Angelina.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end
