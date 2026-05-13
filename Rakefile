require "rake"
require "etc"

task default: :test

task :jekyll do
  require "jekyll"
  Jekyll::Commands::Build.process({ strict_front_matter: true })
end

desc "Run html-proofer to validate the built site."
task test: :jekyll do
  require "html-proofer"

  HTMLProofer.check_directory(
    "./_site",
    allow_hash_href: false,
    allow_missing_href: false,
    cache: {
      timeframe: {
        external: "1h",
      },
    },
    check_external_hash: true,
    check_favicon: true,
    check_html: true,
    check_img_http: true,
    check_opengraph: true,
    enforce_https: true,
    ignore_status_codes: [0, 302, 303, 400, 415, 418, 429, 521],
    parallel: { in_processes: Etc.nprocessors },
    validation: {
      report_eof_tags: true,
      report_invalid_tags: true,
      report_mismatched_tags: true,
      report_missing_doctype: true,
      report_missing_names: true,
      report_script_embeds: true,
    },
  ).run
end
