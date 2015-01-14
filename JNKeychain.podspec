Pod::Spec.new do |s|
  s.name             = "JNKeychain"
  s.version          = "0.1.2"
  s.summary          = "Simple, easy to use wrapper to store/load/delete values from the Keychain."
  s.homepage         = "https://github.com/jeremangnr/JNKeychain"
  s.license          = 'MIT'
  s.author           = { "Jeremias Nunez" => "jeremias.np@gmail.com" }
  s.source           = { :git => "https://github.com/jeremangnr/JNKeychain.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jereahrequesi'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

end
