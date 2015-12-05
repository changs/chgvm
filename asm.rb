# MOVI R1, #0A
# MOVI A, #03
# ADD R1
# MOV R2, A

program = %w(
  03 01 0A
  03 00 03
  02 01
  01 02 00
)

File.open('test.bin', 'wb') do |out|
  out.write [program.join].pack('H*')
end
