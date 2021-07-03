# frozen_string_literal: true

RSpec.describe Jekyll::Vite::Config do
  let(:config) { ViteRuby.reload_with('VITE_RUBY_ROOT' => SITE_DIR) }
  let(:root) { config.root }
  let(:jekyll_config) { setup_jekyll }

  it 'sets the defaults as expected' do
    expect(config.mode).to eq 'development'
    expect(config.public_dir).to eq '.jekyll-cache'
    expect(config.build_output_dir).to eq config.root.join('.jekyll-cache/vite-dev')
    expect(config.build_cache_dir).to eq config.root.join('.jekyll-cache/vite-build')
  end

  it 'detects the mode based on Jekyll' do
    allow(Jekyll).to receive(:env).and_return('production')
    expect(config.mode).to eq 'production'
  end
end
