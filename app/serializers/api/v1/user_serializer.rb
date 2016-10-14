class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :id,:email,:auth_token
end
