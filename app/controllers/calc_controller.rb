def sum_of_div(num)
  sum = 1
  (2..Math.sqrt(num).ceil - 1).each do |i|
    sum += i if (num % i).zero?
    sum += num / i if (num % i).zero? && i*i != num
  end
  num > 1 ? sum : 0
end

def exists_mutually_friendly(number, n)
  sum_of_div(number) <= n && sum_of_div(sum_of_div(number)) == number && sum_of_div(number) != number
end

class String
  def is_number?
    scan(/\D/).empty?
  end
end

class CalcController < ApplicationController
  def input
  end

  def view
    @result =[]
    is_error = false
    if !params[:n].is_a?(String) || params[:n].empty? || params[:n].to_i > 20000 || params[:n].to_i <= 0
      is_error = true end
    if !is_error
      (1..params[:n].to_i).each do |x|
        if exists_mutually_friendly(x, params[:n].to_i) then @result.push([x > sum_of_div(x) ? sum_of_div(x) : x, x > sum_of_div(x) ? x : sum_of_div(x)])
        end end
      @result = @result.uniq.empty? ? 'Взаимно-дружественные числа в диапазоне от 0 до ' + params[:n] + ' не найдены' : @result.uniq
    else
      @result = 'Ошибка ввода'
    end end
end
