{
	programs.firefox = {
		enable = true;
		profiles.default = {
			extensions.force = true;
			path = "default";
			userChrome = builtins.readFile ./userChrome.css;
		};

		policies = {
			DisablePocket = true;
			FirefoxHome = {
				Search = false;
				TopSites = false;
				SponsoredTopSites = false;
				Highlights = false;
				Pocket = false;
				SponsoredPocket = false;
				Snippets = false;
				Weather = false;
				Locked = true;
			};

			Preferences = {
				"browser.compactmode.show" = true;
				"browser.uidensity" = 1;
				"browser.aboutConfig.showWarning" = false;
				"browser.theme.content-theme" = 0;
				"browser.download.useDownloadDir" = false;
				# browser.uiCustomization.state makes sure the top bar is organized the way I like it
				"browser.uiCustomization.state" = builtins.readFile ./uiCustomization.json;
				"browser.newtabpage.activity-stream.showWeather" = false;
				"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
				"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
				"extensions.pocket.enabled" = false;
			};

			InstallAddonsPermission.Default = true;
			ExtensionSettings = {
				"uBlock0@raymondhill.net" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
					installation_mode = "force_installed";
					private_browsing = true;
				};

				"addon@darkreader.org" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
					installation_mode = "force_installed";
				};
			};
		};
	};
}