Pod::Spec.new do |s|

  s.name         = 'APEGroupTableViewCell'
  s.version      = '1.0.0'
  s.summary      = 'APEGroupTableViewCell'
  s.homepage     = 'https://github.com/ZacharyArno/APEGroupTableViewCell'
  s.license      = 'MIT'
  s.author       = { 'Zachary' => 'poisontusk@gmail.com' }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source       = {
      :git => 'git@github.com:ZacharyArno/APEGroupTableViewCell.git',
      :tag => s.version.to_s
  }

  s.source_files = 'Source/**/*.{h,m}'

end
