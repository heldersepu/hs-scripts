resource "local_file" "test" {
    content     = "Hello World!"
    filename = "~/.test/hello.world"
}