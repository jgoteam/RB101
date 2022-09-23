require 'yaml'
MESSAGES = YAML.load_file('mortgage_messages.yml')

def prompt(message)
  message = MESSAGES[message]
  puts("=> #{message}")
end

def valid?(num, option)
  case option
  when 'p'
    /^\d*\.?\d+$/.match(num) && num.to_f >= 1.00
  when 'a'
    num.to_f >= 0.0 && num.to_f <= 100.0
  when 'd'
    num.to_i >= 1 && num.to_i <= 600
  end
end

def usd(num)
  if num.to_s.include?('.')
    num_with_d = format("%.2f", num)
    whole, decimal = num_with_d.split('.')
    whole_w_commas = whole.chars.reverse.each_slice(3)
                          .map(&:join).join(",").reverse
    [whole_w_commas, decimal].join(".").insert(0, "$ ")
  else
    num.chars.reverse.each_slice(3)
       .map(&:join).join(",").reverse.insert(0, "$ ")
  end
end

prompt('welcome')

history = []
loop do
  menu_option = ''
  loop do
    prompt('options')
    menu_option = gets.chomp.strip.downcase
    system('clear') || system('cls')
    case menu_option
    when 'c'
      break
    when 'd'
      prompt('definitions')
    when 'h'
      if history.empty?
        prompt('no_history')
      else
        prompt('history')
        puts history
      end
    when 'q'
      prompt('goodbye')
      exit(true)
    else
      prompt('invalid_option')
    end
  end

  loop do
    prompt('principal')
    principal = gets.chomp.strip
    principal = principal.delete ","
    until valid?(principal, 'p')
      prompt('invalid_p')
      principal = gets.chomp.strip
    end

    prompt('apr')
    apr = gets.chomp.strip
    until valid?(apr, 'a')
      prompt('invalid_apr')
      apr = gets.chomp.strip
    end

    prompt('duration')
    duration = gets().chomp().strip()
    until valid?(duration, 'd')
      prompt('invalid_duration')
      duration = gets.chomp.strip
    end

    if apr.to_f.zero?
      m_payment = principal.to_f / duration.to_i
    else
      m_payment = principal.to_f * (((apr.to_f / 100) / 12) /
      (1 - (1 + ((apr.to_f / 100) / 12))**((-1) * (duration.to_i))))
    end
    total_interest = (m_payment.to_f * duration.to_i) - principal.to_f
    total_paid = principal.to_f + total_interest

    result =
      "\tFor a #{usd(principal)} mortgage " \
        "at #{apr}% APR, #{duration} month(s):\n" \
      "\t\tMonthly payment: #{usd(m_payment)}\n" \
      "\t\tTotal interest: #{usd(total_interest)}\n" \
      "\t\tTotal principal and interest (without fees): #{usd(total_paid)}\n"
    puts result
    history.push(result)

    prompt('calculate_again')
    again = gets.chomp.strip
    system('clear') || system('cls')
    break unless again.downcase.start_with?('y')
  end
end
