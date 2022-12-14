process: migrate
	@node -r dotenv/config lib/processor.js


build:
	@npm run build


serve:
	@npx squid-graphql-server


migrate:
	@npx squid-typeorm-migration apply


codegen:
	@npx --yes @subsquid/typeorm-codegen


typegen-kusama:
	@npx --yes @subsquid/substrate-typegen typegen/typegen-kusama.json
typegen-polkadot:
	@npx --yes @subsquid/substrate-typegen typegen/typegen-polkadot.json

typegen: typegen-kusama typegen-polkadot

up:
	@docker-compose up -d

down:
	@docker-compose down

deploy:
	@API_DEBUG=true npx sqd squid update staking-$(network)@$(version) --source github.com/tdf-labs/squid-staking.git#main -v -e NETWORK=$(network)

.PHONY: build serve process migrate codegen typegen up down
