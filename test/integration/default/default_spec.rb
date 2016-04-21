describe 'aircover::default' do
  # Inspec examples can be found at
  # https://docs.chef.io/inspec_reference.html

  it 'starts aircover' do
    expect(command("curl -s http://localhost | grep '<title>Aircover</title>'").exit_status).to eq 0
  end
end
