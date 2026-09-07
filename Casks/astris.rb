cask "astris" do
  version "1.0.26,3acc192af"
  sha256 "b392d0d9017090eb87855907d016b89d1b7d0414a109505077eba235209f62e8"

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
