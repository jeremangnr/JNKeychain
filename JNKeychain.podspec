#
# Be sure to run `pod lib lint JNKeychain.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "JNKeychain"
  s.version          = "0.1.0"
  s.summary          = "Simple, easy to use wrapper to store/load/delete values from the Keychain."
  s.homepage         = "https://github.com/jeremangnr/JNKeychain"
  s.license          = 'MIT'
  s.author           = { "Jeremias Nunez" => "jeremias.np@gmail.com" }
  s.source           = { :git => "https://github.com/jeremangnr/JNKeychain.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jereahrequesi'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'JNKeychain' => ['Pod/Assets/*.png']
  }

end
