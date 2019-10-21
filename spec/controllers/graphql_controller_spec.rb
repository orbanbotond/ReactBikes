require 'support/schemas/users/create'

RSpec.describe GraphqlsController, type: :controller do
  describe 'POST #create' do
    let(:mutation) do
      '
        mutation($email: String!, $password: String!, $passwordConfirmation: String!) {
          userCreate(input: {
            email: $email,
            password: $password,
            passwordConfirmation: $passwordConfirmation
          }) {
            user {
              id,
              email
            },
            errors {
              messages,
              path
            }
          }
        }
      '
    end

    context 'fail' do
      context 'invalid params' do
        let(:variables) do
          {
            email: '',
            password: '',
            passwordConfirmation: ''
          }
        end

        before { post :create, params: { query: mutation, variables: variables } }

        it 'has errors' do
          expect(response).to match_schema(CreateUserSchema::Error)
          expect(response).to be_ok
        end
      end
    end

    context 'success' do
      let(:variables) do
        {
          email: FFaker::Internet.email,
          password: 'password',
          passwordConfirmation: 'password'
        }
      end

      before { post :create, params: { query: mutation, variables: variables } }

      it 'create session' do
        expect(response).to match_schema(CreateUserSchema::Success)
        expect(response).to be_ok
      end
    end
  end
end
