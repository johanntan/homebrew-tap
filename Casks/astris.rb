cask "astris" do
  version "1.0.32,2398e7c80"
  sha256 "661f01a47816b3baeda5c6c924f92d32e7a2bf42db98483c259207f0eb5feb6f"

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
