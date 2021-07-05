# frozen_string_literal: true

RSpec.describe Jekyll::Vite do
  it 'has a version number' do
    expect(Jekyll::Vite::VERSION).not_to be nil
  end

  describe 'building the site' do
    before do
      stub_env('production')
      config
      FileUtils.rm_rf(ViteRuby.config.build_cache_dir)
      FileUtils.rm_rf(dest)
    end

    context 'when vite succeeds' do
      it 'writes the output' do
        site.process
        expect(dest.exist?).to eq(true)
        expect(dest.join('vite', 'manifest-assets.json').exist?).to eq(true)
      end
    end

    context 'when vite raises an error' do
      before do
        allow_any_instance_of(ViteRuby::Builder).to receive(:build).and_raise(ArgumentError)
      end

      it 'raises an error' do
        expect { site.process }.to raise_error ArgumentError
        expect(dest.join('vite', 'manifest-assets.json').exist?).to eq(false)
      end
    end
  end
end
