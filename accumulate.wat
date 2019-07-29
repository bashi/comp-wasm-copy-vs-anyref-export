(module
  (func $readU8FromUint8Array (import "env" "readU8FromUint8Array") (param anyref) (param i32) (result i32))
  (memory 16384)
  (export "memory" (memory 0))
  (func (export "accumulateCopy") (param $arr i32) (param $length i32) (result i32)
    (local $sum i32)
    i32.const 0
    local.set $sum
    block $label1
      local.get $length
      i32.eqz
      br_if $label1
      loop $label2
        local.get $sum
        local.get $arr
        i32.load8_u
        i32.add
        local.set $sum
        local.get $arr
        i32.const 1
        i32.add
        local.set $arr
        local.get $length
        i32.const -1
        i32.add
        local.tee $length
        br_if $label2
      end
    end
    local.get $sum
  )

  (func (export "accumulateAnyref") (param $arr anyref) (param $length i32) (result i32)
    (local $offset i32)
    (local $sum i32)
    i32.const 0
    local.set $offset
    i32.const 0
    local.set $sum
    block $label1
      local.get $length
      i32.eqz
      br_if $label1
      loop $label2
        local.get $sum
        local.get $arr
        local.get $offset
        call $readU8FromUint8Array
        i32.add
        local.set $sum
        local.get $offset
        i32.const 1
        i32.add
        local.set $offset
        local.get $length
        i32.const -1
        i32.add
        local.tee $length
        br_if $label2
      end
    end
    local.get $sum
  )
)