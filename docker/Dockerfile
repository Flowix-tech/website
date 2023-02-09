FROM node:18-alpine as deps
RUN apk add --no-cache libc6-compat
WORKDIR /app

COPY package.json .
COPY yarn.lock .
RUN yarn install --frozen-lockfile --production

FROM node:18 as build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN rm tsconfig.json && mv tsconfig.build.json tsconfig.json
RUN yarn build


FROM node:18-alpine as runner
WORKDIR /app
ENV NODE_ENV=production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs


COPY --from=build /app/package.json ./package.json
COPY --from=build /app/yarn.lock ./yarn.lock
COPY --from=build /app/node_modules ./node_modules

COPY --from=build /app/public ./public
COPY --from=build /app/.next  ./.next
COPY --from=build --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=build --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

ENV PORT 3000
EXPOSE 3000
CMD ["node", "server.js"]
