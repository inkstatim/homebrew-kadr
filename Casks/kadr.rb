cask "kadr" do
  version "0.1.5"
  sha256 "49622f83a08fa96bc0c1b0f27077ffb457aa945e1bbf1d1bea6d6816230e88dd"

  url "https://github.com/inkstatim/kadr-releases/releases/download/v#{version}/Kadr-#{version}.dmg"
  name "Kadr"
  desc "Screenshots, annotations, OCR and screen recording"
  homepage "https://github.com/inkstatim/kadr-releases"

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
