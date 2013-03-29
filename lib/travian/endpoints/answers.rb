module Travian
  module Endpoints
    module Answers

      ANSWERS_ENDPOINT = 'http://t4.answers.travian.org/?view=toolkit'

      #http://t4.answers.travian.org/?view=toolkit&action=building&gid=22&mb=1&speed=1&linkdescription=here

      #http://t4.answers.travian.org/?view=toolkit&action=buildingconstructiontimes&gid=22&speed=1&linkdescription=this+link

      #http://t4.answers.travian.org/?view=toolkit&action=buildingconstructiontimes&gid=40&speed=1&linkdescription=this+link&unwrapped

      def building(building, options={})
        object_from_response(Travian::BaseBuilding, :answers, '', options.merge(action: 'building', gid: building.id))
      end

      def contruction_times(building, options={})
        object_from_response(Travian::BaseBuilding, :answers, '', options.merge(action: 'buildingconstructiontimes', gid: building.id))

      def answers(request_method, path, options={})
        send(request_method, "#{ANSWERS_ENDPOINT}?#{path}", options.merge(unwrapped: true))
      end

    end
  end
end
