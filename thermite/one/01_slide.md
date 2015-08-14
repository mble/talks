!SLIDE
# **Thermite** #

!SLIDE
Chemical formula for Ruby includes Al<sub>2</sub>O<sub>3</sub> - **aluminimum oxide**

!SLIDE
I am pretty passionate about performance

!SLIDE
I see it as a usability/acessibility problem

!SLIDE
Ruby is not the fastest language

!SLIDE
Not a huge deal(!)

!SLIDE
But when speed matters, **it really matters**

!SLIDE
Sorting, for example

!SLIDE
Or statistics, or anything computationally heavy

!SLIDE
## Enter **Rust**

!SLIDE
Common rust is Fe<sub>2</sub>O<sub>3</sub> - **iron oxide**

!SLIDE
*"..blazingly fast, prevents segfaults, and guarantees thread safety."*

!SLIDE
Compiled, not interpreted

!SLIDE
## Example - Quicksort

!SLIDE code
    @@@rust
    // OrderFunc is a special type that corresponds to a comparitor function
    pub fn quick_sort<T>(v: &mut [T], f: &OrderFunc<T>) {
        let len = v.len();
        if len < 2 {
            return;
        }

        let pivot_index = partition(v, f);
        quick_sort(&mut v[0..pivot_index], f);
        quick_sort(&mut v[pivot_index + 1..len], f);
    }

    fn partition<T>(v: &mut [T], f: &OrderFunc<T>) -> usize {
        let len = v.len();
        let pivot_index = len / 2;

        v.swap(pivot_index, len - 1);

        let mut store_index = 0;
        for i in 0..len - 1 {
            if f(&v[i], &v[len - 1]) {
                v.swap(i, store_index);
                store_index += 1;
            }
        }

        v.swap(store_index, len - 1);
        store_index
    }

!SLIDE code
    @@@ruby
    ##
    # Implementation of Quicksort, using a random pivot
    # Quicksort is, on average, of O(n log(n)) in time complexity
    # and of O(log(n)) space complexity
    # @return [Array] the sorted array
    module Quicksort
      def quicksort
        return self if length <= 1
        pivot = sample
        partition = group_by { |n| n <=> pivot }
        partition.default = []
        partition[-1].quicksort + partition[0] + partition[1].quicksort
      end
    end

!SLIDE
Rust is less expressive

!SLIDE
But much faster!

!SLIDE
Let's see some benchmarks

!SLIDE code
    @@@shell
    ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]

    Random Data Benchmarks
    Warming up --------------------------------------
         Array#quicksort     1.000  i/100ms
          Array#rustsort     1.000  i/100ms

    Calculating -------------------------------------
         Array#quicksort      0.189  (± 0.0%) i/s -      1.000  in   5.299004s
          Array#rustsort      7.706  (± 0.0%) i/s -     39.000  in   5.082234s

    Comparison:
          Array#rustsort:        7.7 i/s
         Array#quicksort:        0.2 i/s - 40.83x slower


!SLIDE code
    @@@shell
    ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]

    Sorted Data Benchmarks
    Warming up --------------------------------------
         Array#quicksort     1.000  i/100ms
          Array#rustsort     1.000  i/100ms

    Calculating -------------------------------------
         Array#quicksort      0.190  (± 0.0%) i/s -      1.000  in   5.259021s
          Array#rustsort     18.526  (±10.8%) i/s -     92.000  in   5.017534s

    Comparison:
          Array#rustsort:       18.5 i/s
         Array#quicksort:        0.2 i/s - 97.43x slower

!SLIDE code
    @@@shell
    ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]

    Random Data Benchmarks
    Warming up --------------------------------------
              Array#sort     1.000  i/100ms
          Array#rustsort     1.000  i/100ms

    Calculating -------------------------------------
              Array#sort      4.437  (± 0.0%) i/s -     23.000  in   5.191888s
          Array#rustsort      7.754  (±12.9%) i/s -     39.000  in   5.057555s

    Comparison:
          Array#rustsort:        7.8 i/s
              Array#sort:        4.4 i/s - 1.75x slower

    ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]

    Sorted Data Benchmarks
    Warming up --------------------------------------
              Array#sort     5.000  i/100ms
          Array#rustsort     1.000  i/100ms

    Calculating -------------------------------------
              Array#sort     54.778  (± 7.3%) i/s -    275.000  in   5.053063s
          Array#rustsort     17.455  (±11.5%) i/s -     86.000  in   5.018995s

    Comparison:
              Array#sort:       54.8 i/s
          Array#rustsort:       17.5 i/s - 3.14x slower

!SLIDE
The Rust implementation is **1.75x faster** than Ruby's native
`Array#sort`!

!SLIDE
The best part?

!SLIDE
**Rust code can be called from Ruby code**

!SLIDE
**Iron oxide + aluminium = thermite**

!SLIDE full-page
![](ThermiteReaction.jpg)

!SLIDE
(With some persuasion)

!SLIDE
## FFI
### Our magnesium

!SLIDE small
*"A foreign function interface (FFI) is a mechanism by which a program written in one programming language can call routines or make use of services written in another"*

!SLIDE
How can we implement an FFI in Ruby?

!SLIDE
3 main ways

!SLIDE
Fiddle

!SLIDE
ruby-ffi

!SLIDE
ruru/helix (extremely experimental)

!SLIDE
Fiddle is built into the Ruby standard library, but is a bit limited

!SLIDE
(No native support for boolean return types)

!SLIDE
ruby-ffi is a gem that provides a very sane library to do this

!SLIDE
## Integrating Rust & Ruby

!SLIDE
We need to prepare our Rust code to be called from Ruby

!SLIDE bullets incremental
* Stop the compiler from mangling the function symbol
* Make the function C ABI compatible
* Return a value that Ruby understands

!SLIDE code
    @@@rust
    #[no_mangle]
    pub extern "C" fn rustsort(n: *const libc::int32_t, len: libc::size_t) -> RubyArray {
        let numbers = unsafe {
            assert!(!n.is_null());
            slice::from_raw_parts(n, len as usize)
        };
        let mut mutable_numbers = numbers.to_owned();
        quick_sort(&mut mutable_numbers, &is_less);

        RubyArray::from_vec(mutable_numbers)
    }

!SLIDE bullets incremental
* `#[no_mangle]` compiler directive stops mangling
* `pub extern "C"` declares the function as a C ABI compatible external public function
* `RubyArray` is a bit of magic ;)

!SLIDE
To call the code from Ruby, we need to do a few things

!SLIDE bullets incremental
* Allow Ruby to call the Rust function
* Pass the Rust function the right datatype
* Handle the returned data

!SLIDE code
    @@@ruby
    ##
    # Contains a link to the Rust library and
    # a struct to aid in marshalling data across
    module Rust
      ##
      # Give Rust library access to modules/classes
      # this module is included in
      def self.included(base)
        base.extend FFI::Library
        base.ffi_lib begin
          pre = Gem.win_platform? ? '' : 'lib'
          suffix = FFI::Platform::LIBSUFFIX
          dirname = File.dirname(__FILE__)
          target = '../../target/release/'
          "#{File.expand_path(target, dirname)}/#{pre}rustsort.#{suffix}"
        end
      end

      ##
      # Struct to handle marshalling data from Rust
      class RustArray < FFI::Struct
        layout :len,  :size_t,
               :data, :pointer

        def to_a
          self[:data].get_array_of_int(0, self[:len]).compact
        end
      end
    end

!SLIDE code
    @@@ruby
    ##
    # Implementation of Quicksort, but in Rust!
    # Uses FFI to cross the boundaries
    # @return [Array] the sorted array
    module Rustsort
      include Utils::Rust
      ##
      # Attach a function that hooks into the Rust library
      attach_function :rust_sort,           # Name
                      :rustsort,            # Rust function
                      [:pointer, :size_t],  # Args
                      RustArray.by_value    # Return

      ##
      # Dup the array, create a pointer containing the array data
      # then pass the pointer over to Rust to let the magic happen
      def rustsort
        arr = dup
        buf = FFI::MemoryPointer.new :int32, arr.size
        buf.write_array_of_int32(arr)
        rust_sort(buf, arr.size).to_a
      end
    end

!SLIDE
## Wrapup

!SLIDE
What have we achieved?

!SLIDE bullets incremental
* Quicksort implementation in Rust & Ruby
* Benchmarked them
* Used FFI to call Rust from Ruby

!SLIDE
What does this mean?

!SLIDE
When speed matters, **it really matters**

!SLIDE
Use the right tool for the job

!SLIDE
## Examples

!SLIDE small
On Github

mble/sorting_algorithms
mble/ffi_example
mble/ruru_experiment

!SLIDE
## Projects

!SLIDE small
On Github

danielpclark/faster_path
malept/thermite   
d-unseductable/ruru   
rustbridge/helix   
rustbridge/neon

!SLIDE
Questions?
