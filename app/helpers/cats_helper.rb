module CatsHelper
  def status_class status
    case status
    when 'meowing'
      'info'
    when 'playing'
      'primary'
    when 'idle'
      'light'
    when 'sleeping'
      'dark'
    else
      'warning'
    end
  end

  def event_class action
    case action
    when 'play'
      'primary'
    when 'meow'
      'info'
    when 'stop'
      'light'
    when 'rest'
      'dark'
    when 'wakeup'
      'warning'
    else
      'secondary'
    end
  end

  def stamina_class stamina
    return 'danger' if stamina < 4
    return 'warning' if stamina < 7
    return 'info' if stamina < 9
    return 'primary'
  end
end
