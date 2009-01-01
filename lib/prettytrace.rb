class Prettytrace
  VERSION = '0.10'

  END {
    # do nothing at normal exit
    next unless $!

    msg, exc, bt = $!.message, $!.class, $!.backtrace.dup

    # print an error message
    msg = case
    when msg.empty? && exc == RuntimeError then "unhandled exception"
    when msg.empty? then exc.to_s
    else "%s (%p)" % [msg, exc]
    end
    puts "#{ bt.shift }: #{ msg }"

    # detect repetations and build backtrace
    hash = {}
    str = bt.map {|ent| hash[ent] ||= hash.size }.reverse.pack("v*")
    buf = []
    while str[/^((?:..)*?)((?:..)+?)(\2{10,})/m]
      left, fragment = [$1, $2].map {|s| s.unpack("v*") }
      buf.concat(left).concat(fragment)
      buf << [($3.bytesize / 2) / fragment.size - 1, fragment. reverse]
      buf.concat(fragment)
      str = $'
    end
    buf.concat(str.unpack("v*"))

    # print backtrace
    hash = hash.invert
    buf.reverse_each do |ent|
      if ent.is_a?(Array)
        # repetition part
        num, fragment = ent
        fragment.each do |ent|
          puts "\t  from #{ hash[ent] }"
        end
        s = fragment.size > 1 ? "s" : ""
        puts "\t  (repeat the above line#{ s } #{ num } times)"
      else
        puts "\tfrom #{ hash[ent] }"
      end
    end

    # suppress an original error print
    exit!
  }
end
