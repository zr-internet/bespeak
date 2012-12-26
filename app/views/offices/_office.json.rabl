object @office

attributes :id, :name, :address, :phone
node(:timeZoneOffset) { |office| office.time_zone.utc_offset }