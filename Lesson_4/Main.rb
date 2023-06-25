require_relative 'Train'
require_relative 'Carriage'
require_relative 'Route'
require_relative 'Station'
require_relative 'PassengerTrain'
require_relative 'CargoTrain'
require_relative 'PassengerCarriage'
require_relative 'CargoCarriage'

class Main
  def initialize
    @carriages = []
    @routes = []
    @stations = []
    @trains = []
  end

  def start
    puts 'Welcome to railway app'
    loop do
      show_menu
      action_number = get_action
      break if action_number == 0
      launch_process(action_number)
    end
  end

  private
  attr_reader :stations, :routes, :trains, :carriages

  def show_menu
    puts "\nAvailable commands:"
    puts "\t 1 - Add station"\
         "\n\t 2 - Station list"\
         "\n\t 3 - Create train"\
         "\n\t 4 - Route management"\
         "\n\t 5 - Add route to train"\
         "\n\t 6 - Move train on route"\
         "\n\t 7 - List train on station"\
         "\n\t 8 - Create carriage"\
         "\n\t 9 - Manage carriage on train"\
         "\n\t 0 - Finish work"
  end

  def get_action
    print 'Enter command num: '
    gets.chomp.to_i
  end

  def launch_process(key)
    case key
    when 1
      create_station
    when 2
      view_stations
    when 3
      create_train
    when 4
      routes_management
    when 5
      assign_route
    when 6
      route_moving
    when 7
      view_trains_on_station
    when 8
      create_carriage
    when 9
      carriage_management
    end
  end

  def select_exist_entity(list_name)
    list = self.send(list_name)
    list.each_with_index do |entity, index|
      puts "#{index + 1}) #{entity.inspect}"
    end
    selected_index = gets.chomp.to_i - 1
    list[selected_index]
  end

  def create_station
    print 'Enter station name: '
    station_name = gets.chomp.to_s
    station = Station.new(station_name)
    puts "Station created: #{station.inspect}"
    @stations << station
  end

  def view_stations
    puts "\nStation list:"
    stations.each{|station| puts station.station_name}
  end

  def create_train
    puts "Enter type of the train:"\
         "\n\t 1 - Cargo "\
         "\n\t 2 - Passenger"
    train_type = gets.chomp.to_i
    print 'Enter number of train: '
    train_number = gets.chomp.to_i
    case train_type
    when 1
      cargo_train = CargoTrain.new(train_number)
      @trains << cargo_train
      puts "Created cargo train: #{cargo_train.inspect}"
    when 2
      passenger_train = PassengerTrain.new(train_number)
      @trains << passenger_train
      puts "Created  passenger train: #{passenger_train.inspect}"
    end
  end

  def routes_management
    puts "Choose action:"\
    "\n\t 1 - Create route"\
    "\n\t 2 - Manage exist route"
    select = gets.chomp.to_i
    case select
    when 1
      create_route
    when 2
      edit_route
    end
  end

  def create_route
    puts "Choose starting station:"
    start_station = select_exist_entity(:stations)

    puts "Choose ending station:"
    end_station = select_exist_entity(:stations)

    route = Route.new(start_station, end_station)
    @routes << route
    puts "Route created #{route.inspect}"
  end

  def edit_route
    puts "Choose editing route:"
    selected_route = select_exist_entity(:routes)
    puts "Choose operation on route #{selected_route.inspect}:"\
         "\n\t 1 - attach station"\
         "\n\t 2 - detach station"
    route_operation = gets.chomp.to_i
    case route_operation
    when 1
      puts "Choose station to add:"
      station_to_add = select_exist_entity(:stations)
      selected_route.add_station(station_to_add)
      puts "Station add to route #{station_to_add.station_name}"
      puts "New route: #{selected_route.inspect}"
    when 2
      puts "Choose station should to remove from route:"
      selected_route.stations.each_with_index do |station, index|
        puts "#{index + 1} - #{station.inspect}"
      end
      station_to_delete_index = gets.chomp.to_i - 1
      station_to_delete = selected_route.stations[station_to_delete_index]
      delete_result = selected_route.delete_station(station_to_delete)
      if delete_result
        puts "from route delete station #{station_to_delete.name}"
        puts "new route: #{selected_route.inspect}"
      else
        puts "You trying delete starting or ending station"
      end
    end
  end

  def assign_route
    puts "Choose train to add route:"
    selected_train = select_exist_entity(:trains)
    puts "Choose route to add to train:"
    selected_route = select_exist_entity(:routes)
    selected_train.set_route(selected_route)
    puts "For train #{selected_train.inspect}"
    puts "add route #{selected_route.inspect}"
  end

  def route_moving
    puts "Choose moving train:"
    train = select_exist_entity(:trains)
    puts "Train at station #{train.current_station.station_name}"
    puts "Where we should go?"\
    "\n\t 1 - move to next station"\
    "\n\t 2 - move to previous station"
    move_operation = gets.chomp.to_i
    case move_operation
    when 1
      if train.move_to_next_station
        puts "train #{train} move forward, current station = #{train.current_station.station_name}"
      else
        puts "train can't move forward from ending station"
      end
    when 2
      if train.move_to_previous_station
        puts "train #{train} move backward, current station = #{train.current_station.station_name}"
      else
        puts "train can't move back from ending station"
      end
    end
  end

  def view_trains_on_station
    puts "Choose station to see list of the train:"
    station = select_exist_entity(:stations)
    if station
      puts "\nList train on station #{station.station_name}"
      station.trains.each{|train| puts train.inspect}
    end
  end

  def create_carriage
    puts "Enter carriage type to create:"\
    "\n\t 1 - Cargo "\
    "\n\t 2 - Passenger"
    carriage_type = gets.chomp.to_i
    case carriage_type
    when 1
      carriage = CargoCarriage.new
      @carriages << carriage
      puts "Cargo carriage created: #{carriage}"
    when 2
      carriage = PassengerCarriage.new
      puts "Passenger cargo created: #{carriage}"
      @carriages << carriage
    end
  end

  def carriage_management
    puts "Choose train to manage carriage:"
    selected_train = select_exist_entity(:trains)
    puts "choose operation:"\
    "\n\t 1 - attach carriage "\
    "\n\t 2 - detach carriage"
    carriage_operation = gets.chomp.to_i
    case carriage_operation
    when 1
      add_carriage(selected_train)
    when 2
      delete_carriage(selected_train)
    end
  end

  def add_carriage(selected_train)
    puts "choose carriage to attach"
    selected_carriage = select_exist_entity(:carriages)
    result = selected_train.attach_carriage(selected_carriage)
    if result
      puts "for train #{selected_train.inspect} added carriage #{selected_carriage}"
    else
      puts "for train #{selected_train.inspect} carriage #{selected_carriage} can't to add, "
    end
  end

  def delete_carriage(selected_train)
    puts "Choose carriage to detach: "
    selected_train.carriages.each_with_index do |carriage, index|
      puts "#{index + 1} - #{carriage.inspect}"
    end
    carriage_to_delete_index = gets.chomp.to_i - 1
    carriage_to_delete = selected_train.carriages[carriage_to_delete_index]
    selected_train.detach_carriage(carriage_to_delete)
    puts "From train #{selected_train.inspect} deleted carriage #{carriage_to_delete}"
  end
end

Main.new.start