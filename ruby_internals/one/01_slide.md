!SLIDE
# **Ruby Internals 1** #
## Lexing, Parsing & Method Dispatch

!SLIDE
# Out of ?

!SLIDE
# Why do you care about the internals of Ruby?

!SLIDE
# *“A good craftsman never blames his tools.”*

!SLIDE
# So next time you see an error like this:

!SLIDE code
    @@@ruby
    syntax error, unexpected tIDENTIFIER, expecting ')'


!SLIDE
# You don't go: *“FSCKING RUBY!”*

!SLIDE
# **Running Ruby Programs**

!SLIDE
# How many times is your Ruby program read?

!SLIDE
# **3!**

!SLIDE
# Tokenize > Parse > Compile

!SLIDE
# Program parsing is handled by Bison, an LALR parser

!SLIDE
# This means *Look-Ahead Left Reversed Rightmost Derivation*

!SLIDE
# Essentially, it looks ahead, decides which grammar rule to match
# while moving left to right, while using a *shift/reduce* technique
# to match the rules

!SLIDE
# Ruby grammar is in *parse.y*, which is **absolutely massive**

!SLIDE
# (10,000+ lines of code)

!SLIDE
# Here's an example of parsing in action! (`ruby -y simple.rb`)

!SLIDE
# All this to get to instructions which are run on the Ruby VM (YARV)

!SLIDE
# YARV is for a (much) later time

!SLIDE
# Though I'll show you a bit now! (`ruby yarv_instructions.rb`)

!SLIDE
# **Flow Control & Method Dispatch**

!SLIDE
# One of the most (if not the most) common statement in Ruby is
      @@@ruby
      if...else

!SLIDE
# How does Ruby evaluate this?

!SLIDE
# The key is a `branchunless` YARV instruction

!SLIDE
# Example

!SLIDE code
      @@@ruby
      # example.rb
      1 = 0
      if i < 10
        puts 'small'
      else
        puts 'large'
      end

!SLIDE code
      @@@python
      # ...
      0009 putobject         10
      0011 opt_lt            <callinfo!mid:<, argc:1
      0013 branchunless      25
      0015 trace
      0017 putself
      0018 putstring         "small"
      # ...
      0025 trace
      0027 putself
      0028 putstring         "large"

!SLIDE
# The most used YARV instruction is `send`

!SLIDE
# Seem familiar?

!SLIDE
# How does YARV know what method to call? How does it call the method?

!SLIDE bullets incremental
* YARV calls `send`
* Method Lookup
* Method Dispatch
* YARV executes target method

!SLIDE
# Quick and dirty explanations of method *lookup* and *dispatch*

!SLIDE
# Methods are categorised into 11 different types for YARV
# Most common is `ISEQ`, or *instruction sequence*

!SLIDE
# YARV loops through all the classes and modules that make
#up a receiver object

!SLIDE
# YARV's internal *stack* gains a new *frame* containing method args
# YARV's internal *registers* are changed to execute the method

!SLIDE
# Method dispatch actually optimises `attr_reader` and `attr_writer`
# They use special method categories: `IVAR` and `ATTRSET`

!SLIDE
# Next time: Objects, Classes and Modules

!SLIDE
# Questions?
