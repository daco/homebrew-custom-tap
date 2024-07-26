class ElasticsearchAT6820 < Formula
  desc "Distributed search & analytics engine"
  homepage "https://www.elastic.co/products/elasticsearch"
  url "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.8.20.tar.gz"
  sha256 "f0a93f9465fc34c1e18b83fef9c1e179f62452f5aa1e6cfb0ad9b6e6a70be37a"
  license "Apache-2.0"

  depends_on "openjdk@8"

  def install
    # Remove Windows files
    rm_rf Dir["bin/*.bat"]
    libexec.install "bin", "config", "lib", "modules"
    (bin/"elasticsearch").write_env_script libexec/"bin/elasticsearch", Language::Java.overridable_java_home_env("1.8")
    (bin/"elasticsearch-plugin").write_env_script libexec/"bin/elasticsearch-plugin", Language::Java.overridable_java_home_env("1.8")
  end

  plist_options manual: "elasticsearch"

  service do
    run [opt_bin/"elasticsearch"]
    keep_alive true
    working_dir var
    log_path var/"log/elasticsearch.log"
    error_log_path var/"log/elasticsearch.log"
  end

  test do
    system bin/"elasticsearch", "-V"
  end
end
