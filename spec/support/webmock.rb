require 'webmock'

def fixture(file)
  IO.read("#{Dir.pwd}/spec/fixtures/#{file}")
end

WebMock.stub_request(:get, 'https://api.github.com/user/repos')
       .with(
         headers: {
           'Accept' => 'application/vnd.github.v3+json',
           'Authorization' => 'token foobar'
         }
       )
       .to_return(fixture('user-repos.json'))

WebMock
  .stub_request(:get, 'https://api.github.com/user/repos?page=2&per_page=1')
  .with(
    headers: {
      'Accept' => 'application/vnd.github.v3+json',
      'Authorization' => 'token foobar'
    }
  )
  .to_return(fixture('user-repos-page-2.json'))

WebMock.stub_request(:get, 'https://api.github.com/user/repos')
       .with(
         headers: {
           'Accept' => 'application/vnd.github.v3+json',
           'Authorization' => 'token badtoken'
         }
       )
       .to_return(fixture('bad_credentials.json'))
