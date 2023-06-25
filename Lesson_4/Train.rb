class Train
  attr_reader :number, :type, :carriages, :speed, :route

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
  end

  def increase_speed(speed)
    @speed += speed
  end

  def decrease_speed(speed)
    @speed -= speed
    @speed = 0 if @speed.negative?
  end

  def attach_carriage(carriage)
    @carriages << carriage if @speed.zero?
  end

  def detach_carriage(carriage)
    @carriages.delete(carriage) if @speed.zero?
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
    route.stations[0].train_arrived(self)
  end

  def move_to_next_station
    return unless next_station

    current_station.train_send(self)
    @current_station_index += 1
    current_station.train_arrived(self)
  end

  def move_to_previous_station
    return unless previous_station

    current_station.train_send(self)
    @current_station_index -= 1
    current_station.train_arrived(self)
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index.positive?
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index < @route.stations.length - 1
  end
end