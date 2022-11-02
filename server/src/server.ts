import Fastify from "fastify";
import { PrismaClient } from "@prisma/client";

import cors from "@fastify/cors";

const prisma = new PrismaClient({
  log: ["query"],
});

async function boostrap() {
  const fastify = Fastify({
    logger: true,
  });

  await fastify.register(cors, {
    origin: true,
  });

  fastify.get("/pools/count", async (request, replay) => {
    const pools = await prisma.pools.count();

    return { count: pools };
  });

  await fastify.listen({ port: 3333, host: "0.0.0.0" });
}

boostrap();
