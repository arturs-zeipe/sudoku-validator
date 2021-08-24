class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    
    isUnfinished = false
    
    # Row validation
    @puzzle_string.split("\n").each do |row|                        # Sadala padoto sudoku puzli rindās
      if row != '------+------+------'
        rowNumbers = []
        rowEmpty = []
        row.split(' ').each do |col|                                # Sadala rindas atsevišķos elementos
          case col                                                  # Pārbauda īpašos gadījumus un neizpildītos laukumus
          when '|1'
            rowNumbers.push("1")
          when '|2'
            rowNumbers.push("2")
          when '|3'
            rowNumbers.push("3")
          when '|4'
            rowNumbers.push("4")
          when '|5'
            rowNumbers.push("5")
          when '|6'
            rowNumbers.push("6")
          when '|7'
            rowNumbers.push("7")
          when '|8'
            rowNumbers.push("8")
          when '|9'
            rowNumbers.push("9")
          when '|0'
            rowEmpty.push("0")
          when '0'
            rowEmpty.push("0")
          else
            rowNumbers.push(col)
          end
        end
        if rowEmpty.count + rowNumbers.uniq.count < 9
          return "Sudoku ir nederīgs."                              # Atgriež sudoku ir nederīgs, ja kāds skaitlis atkārtojas un nav unikāls
        end
        if rowEmpty.count > 0
          return "Sudoku ir derīgs, bet nepabeigts."                # Atgriež sudoku ir derīgs, bet nav pabeigts
        end
      end
    end
    
    # Column validation
    i = 0
    column_index = 0
    while i < 9
      columnNumbers = []
      @puzzle_string.split("\n").each do |row|                      # Sadala padoto sudoku puzli rindās
        if row != '------+------+------'
          columnNumbers << row[column_index]                        # Piešķir kolonnas skaitļu masīvam kolonnu, ko nosaka kolonnas indekss
        end
      end
      #puts "selected items: #{columnNumbers.inspect}"
      column_index += 2                                             # Palielina kolonnas indeksu par 2, lai neiekļautu tukšās rindas
      if @puzzle_string.split("\n").first[column_index] == '|'
        column_index += 1                                           # Palielina kolonnas indeksu par 1, ja elements ir vertikālā līnija
      end
      # puts columnNumbers.uniq.count
      if columnNumbers.uniq.count < 9
        return "Sudoku ir nederīgs."                                # Atgriež sudoku nav derīgs, ja kolonnā atkārtojās cipari
      end
      i += 1
    end

    # Square validation
    # TODO

    # Atrod rindas pirmos 3 elementus un ieliek masīvā, nākamos 3 citā masīvā, un pēdējos 3 citā masīvā
    # To pašu dara ar nākamajām rindām
    # Kad masīvā ir ielikti 9 elementi, tad to vairs neizmanto un taisa jaunu
    # Pārbauda katru masīvu vai skaitļi ir unikāli

    return "Sudoku ir derīgs."                                      # Atgriež sudoku ir derīgs, ja iziet visas augstāk minētās pārbaudes
  end
end
