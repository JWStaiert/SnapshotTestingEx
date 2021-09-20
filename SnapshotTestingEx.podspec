Pod::Spec.new do |s|
  s.name = "SnapshotTestingEx"
  s.version = "0.0.1"
  s.summary = "Pixel component diffing strategies for SnapshotTesting with fuzzy matching"

  s.description = <<-DESC
  Pixel component diffing strategies for SnapshotTesting with fuzzy matching and improved assertSnapshot execution times for image related Apple SDK types, including: CGImage, NSImage, UIImage, and CGContext.
  DESC

  s.homepage = "https://github.com/JWStaiert/SnapshotTestingEx"

  s.license = "MIT"

  s.authors = {
    'Jason William Staiert' => 'jason.william.staiert@gmail.com'
  }

  s.source = {
    :git => "https://github.com/JWStaiert/SnapshotTestingEx.git",
    :tag => s.version
  }

  s.swift_versions = "5.0", "5.1.2", "5.2"

  s.ios.deployment_target = "11.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "10.0"

  s.dependency "SnapshotTesting"
  s.frameworks = "XCTest"

  s.source_files = "Sources/**/*.{swift,h,m}"
end
