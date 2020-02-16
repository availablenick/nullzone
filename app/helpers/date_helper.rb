module DateHelper
  def week_day(day)
    days_array = ['Domingo', 'Segunda-feira',
    'Terça-feira', 'Quarta-feira', 'Quinta-feira',
    'Sexta-feira', 'Sábado']

    return days_array[day]
  end

  def format_date(date, omit_day = false)
    fdate = ""
    if !omit_day
      fdate += week_day(date.wday) + ', '
    end

    fdate += date.strftime('%d/%m/%y') + ' às ' + date.strftime('%R')
    return fdate
  end
end
