# frozen_string_literal: true

RSpec.describe Jekyll::Vite::Config do
  let(:jekyll_config) { setup_jekyll }

  it 'sets the defaults as expected' do
    stub_env('development')
    expect(config.mode).to eq 'development'
    expect(config.public_dir).to eq '.jekyll-cache'
    expect(config.build_output_dir).to eq config.root.join('.jekyll-cache/vite-dev')
    expect(config.build_cache_dir).to eq config.root.join('.jekyll-cache/vite-build')
  end

  it 'detects the mode based on Jekyll' do
    stub_env('production')
    expect(config.mode).to eq 'production'
  end
end
