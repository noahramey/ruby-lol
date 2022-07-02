module Lol
  # Bindings for the League API.
  #
  # See: https://developer.riotgames.com/api-methods/#league-v3
  class LeagueRequest < Request
    # @!visibility private
    def api_base_path
      "/lol/league/#{api_version}"
    end

    # Get the challenger league for a given queue
    # @param [String] queue Queue identifier. See the list of game constants (developer.riotgames.com/game-constants.html) for the available queue identifiers
    # @return [DynamicModel] Challenger league
    def find_challenger(queue='RANKED_SOLO_5x5')
      DynamicModel.new perform_request api_url "challengerleagues/by-queue/#{queue}"
    end

    # Get the master league for a given queue
    # @param [String] queue Queue identifier. See the list of game constants (developer.riotgames.com/game-constants.html) for the available queue identifiers
    # @return [DynamicModel] Master league
    def find_master(queue='RANKED_SOLO_5x5')
      DynamicModel.new perform_request api_url "masterleagues/by-queue/#{queue}"
    end

    # Get the grandmaster league for a given queue
    # @param [String] queue Queue identifier. See the list of game constants (developer.riotgames.com/game-constants.html) for the available queue identifiers
    # @return [DynamicModel] Grandmaster league
    def find_master(queue='RANKED_SOLO_5x5')
      DynamicModel.new perform_request api_url "grandmasterleagues/by-queue/#{queue}"
    end

    # Get all the league entries by queue, tier, and division
    # @param [String] queue Queue identifier. See the list of game constants (developer.riotgames.com/game-constants.html) for the available queue identifiers
    # @param [String] tier Tier identifier. Defaults to 'DIAMOND'
    # @param [String] division Division identifier. Defaults to 'I'
    # @return [Array<DynamicModel>] List of entries
    def find_entries(queue='RANKED_SOLO_5x5', tier='DIAMOND', division='I')
      result = perform_request api_url "entries/#{queue}/#{tier}/#{division}"
      result.map { |c| DynamicModel.new c }
    end

    # Get all the league entries in all queues for a given summoner ID.
    # @param [String] summoner_id Summoner ID associated with the player
    # @return [Array<DynamicModel>] List of entries
    def find_entries_by_summoner_id(summoner_id)
      result = perform_request api_url "entries/by-summoner/#{summoner_id}"
      result.map { |c| DynamicModel.new c }
    end
  end
end
