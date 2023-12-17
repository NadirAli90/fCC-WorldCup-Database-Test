#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals; do
 #not Opponent 
  if [[ $opponent != opponent ]]; then
    name=$($PSQL "SELECT name FROM teams WHERE name='$opponent'")

    if [[ -z $name ]]; then
      INSERT_NAME=$($PSQL "INSERT INTO teams(name) VALUES ('$opponent')")
      if [[ $INSERT_NAME == "INSERT 0 1" ]]; then
        echo "\n name inserted into team is '$opponent'"
        fi
    fi
  fi

    if [[ $winner != winner ]]; then
    name=$($PSQL "SELECT name FROM teams WHERE name='$winner'")

    if [[ -z $name ]]; then
      INSERT_NAME=$($PSQL "INSERT INTO teams(name) VALUES ('$winner')")
      if [[ $INSERT_NAME == "INSERT 0 1" ]]; then
        echo "name inserted into team is '$winner'"
        fi
    fi
  fi
done

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals; do

if [[ $year != year && $round != round && $winner != winner && $opponent != opponent && $winner_goals != winner_goals && $opponent_goals != opponent_goals ]]; then
  if [[ $winner != winner ]]; then
      winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")

      if [[ -z $winner ]]; then
          winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
      fi
  fi

  if [[ $opponent != opponent ]]; then
      opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")

      if [[ -z $opponent ]]; then
          opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
      fi
  fi

  INSERT_DATA=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ('$year', '$round', '$winner_id', '$opponent_id', $winner_goals, $opponent_goals)")
  if [[ $INSERT_DATA == "INSERT 0 1" ]]; then
  echo "Data inserted'$year', '$round', '$winner_id', '$opponent_id', $winner_goals, $opponent_goals"
  fi
fi
done
