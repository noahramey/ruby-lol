module Lol
  # Bindings for the Match API.
  #
  # See: https://developer.riotgames.com/api-methods/#match-v5
  class MatchRequest < Request
    # Returns the API Version.
    # @return [String] v5
    def self.api_version
      "v5"
    end

    def self.platforms
      {
        :br   => 'americas',
        :eune => 'europe',
        :euw  => 'europe',
        :jp   => 'asia',
        :kr   => 'asia',
        :lan  => 'americas',
        :las  => 'americas',
        :na   => 'americas',
        :oce  => 'sea',
        :ru   => 'europe',
        :tr   => 'europe',
      }
    end

    # @!visibility private
    def api_base_path
      "/lol/match/#{self.class.api_version}"
    end

    # Get match by match ID.
    # @param [String] match_id Match ID
    # @option options [Integer] forAccountId Optional used to identify the participant to be un-obfuscated
    # @option options [Integer] forPlatformId Optional used to identify the participant to be un-obfuscated (for when user have changed regions)
    # @return [DynamicModel] Match representation
    def find(match_id, options={})
      DynamicModel.new perform_request api_url "matches/#{match_id}", options
    end

    # Get match timeline by match ID.
    # @param [String] match_id Match ID
    # @return [DynamicModel] Timeline representation
    def find_timeline(match_id)
      DynamicModel.new perform_request api_url "matches/#{match_id}/timeline"
    end

    # Get match list for last 20 matches played on given account ID and platform ID.
    # @param [String] puu_id Puu ID
    # @return [DynamicModel] MatchList representation
    def all(puu_id, options={})
      start = options['start'] || 0
      count = options['count'] || 20
      ids = perform_request api_url "matches/by-puuid/#{puu_id}/ids", {start: start, count: count}
      return ids
    end
  end
end
