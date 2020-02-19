WHEEL_GID = 10

%w[
hsbt
mame
k0kubun
nobu
].each do |u|
  user u do
    action :create
  end

  user u do
    gid WHEEL_GID
  end

  directory "/home/#{u}" do
    mode  "755"
    owner u
  end

  directory "/home/#{u}/.ssh" do
    mode  "700"
    owner u
  end

  file "/home/#{u}/.ssh/authorized_keys" do
    mode  "600"
    owner u
    content File.read("keys/#{u}.keys")
  end
end

user "chkbuild"
directory "/home/chkbuild" do
  mode  "755"
  owner "chkbuild"
end

node.reverse_merge!(
  rbenv: {
    user: 'chkbuild',
    global: '2.5.7',
    versions: %w[
      2.5.7
    ],
  }
)

include_recipe "rbenv::user"
