cask "kadr" do
  version "0.1.7"
  sha256 "39f7ab500331a415dbf78118d76da442eec07d3cf7989a95d8f08502e7db8d7d"

  url "https://github.com/inkstatim/kadr-releases/releases/download/v#{version}/Kadr-#{version}.dmg"
  name "Kadr"
  desc "Screenshots, annotations, OCR and screen recording"
  homepage "https://inkstatim.dev/kadr/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Kadr.app"

  # Kadr не заверен Apple: снимаем карантин, чтобы macOS не спрашивала про неизвестного разработчика.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Kadr.app"],
        must_succeed:   false,
        writable_paths: ["Kadr.app"],
        writable_base:  :appdir
  end

  uninstall quit: "dev.inkstatim.kadr"

  zap trash: [
    "~/Library/Application Support/Kadr",
    "~/Library/Preferences/dev.inkstatim.kadr.plist",
  ]
end
