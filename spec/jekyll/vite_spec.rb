# frozen_string_literal: true

RSpec.describe Jekyll::Vite do
  Jekyll.logger.log_level = :error

  SPEC_FIXTURES_DIR = File.expand_path('../fixtures', __dir__)

  let(:config_overrides) { {} }
  let(:configs) do
    Jekyll.configuration(
      config_overrides.merge(
        'skip_config_files' => false,
        'collections' => { 'docs' => { 'output' => true } },
        'source' => fixtures_dir,
        'destination' => fixtures_dir('_site'),
      ),
    )
  end
  let(:webpacker)    { described_class }
  let(:site)         { Jekyll::Site.new(configs) }
  let(:posts)        { site.posts.docs.sort.reverse }

  it 'has a version number' do
    expect(Jekyll::Webpack::VERSION).not_to be nil
  end

  let(:bad_js_src_off) { "#{ SPEC_FIXTURES_DIR }/src/controllers/hello_controller.syntax.js.off" }
  let(:bad_js_src_on) { "#{ SPEC_FIXTURES_DIR }/src/controllers/hello_controller.syntax.js" }

  let(:bad_js_dest_off) { "#{ SPEC_FIXTURES_DIR }/_site/src/controllers/hello_controller.syntax.js.off" }
  let(:bad_js_dest_on) { "#{ SPEC_FIXTURES_DIR }/_site/src/controllers/hello_controller.syntax.js" }

  describe 'building the site' do
    context 'when webpack succeeds' do
      before do
        if File.exist?(bad_js_src_on)
          File.delete(bad_js_src_on)
        end

        if File.exist?(bad_js_dest_on)
          File.delete(bad_js_dest_on)
        end
        site.reset
        site.read
        (site.pages | posts | site.docs_to_write).each { |p| p.content.strip! }
        site.render
      end

      it 'writes the output' do
        site.write
        expect(File.exist?(site.dest)).to eq(true)
      end
    end

    context 'when webpack raises an error' do
      before do
        FileUtils.cp(bad_js_src_off, bad_js_src_on)
        site.reset
        site.read
        (site.pages | posts | site.docs_to_write).each { |p| p.content.strip! }
        site.render
      end

      it 'raises an error' do
        expect { site.write }.to raise_error Jekyll::Webpack::Error
      end

      after do
        File.delete(bad_js_src_on)

        if File.exist?(bad_js_dest_on)
          File.delete(bad_js_dest_on)
        end
      end
    end
  end
end
