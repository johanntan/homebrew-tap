cask "astris" do
  version "1.0.30,115dc1ae0"
  sha256 "c36b95aaa24c40b2cab7216e4b412c1930c237f2c24f597106c507328b0ca240"

  url "https://github.com/V380-Ori/Astris.Binaries/releases/download/astris-#{version.csv.first}/Astris-#{version.csv.first}%2B#{version.csv.second}.dmg"
  name "Astris"
  desc "Nintendo Switch 1 emulator based on Ryujinx"
  homepage "https://github.com/V380-Ori/Astris.Binaries"

  livecheck do
    url :url
    regex(/^Astris[._-]v?(\d+(?:\.\d+)+)\+([a-f\d]+)\.dmg$/i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Astris.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Astris.app"]
  end

  caveats <<~EOS
    Astris is ad-hoc signed and is not notarized by Apple. This cask removes
    the macOS quarantine attribute from Astris.app after installation, which
    bypasses Gatekeeper for this app. Only install it if you trust upstream.
  EOS
end
